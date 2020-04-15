package biolockj.module.getData.sra;

import java.io.File;
import java.util.List;
import biolockj.Config;
import biolockj.exception.ConfigException;
import biolockj.exception.ConfigFormatException;
import biolockj.module.ScriptModuleImpl;
import biolockj.util.DockerUtil;

public abstract class SequenceReadArchive extends ScriptModuleImpl {
	
	
	@Override
	public Boolean isValidProp( String property ) throws Exception {
	    Boolean isValid = super.isValidProp( property );
	    switch(property) {
	    	case DB_DIR:
	        	File dbFolder = Config.requireExistingDir( this, DB_DIR );
	    		File dbFile = new File(dbFolder, DB_NAME);
	    		if ( dbFile.exists() && ! dbFile.canRead() ) {
	    			throw new ConfigException(DB_DIR, "The database [" + dbFile.getAbsolutePath() + "] exists, but is not readable.");
	    		}
	    		if ( ! DockerUtil.inDockerEnv() && ! dbFile.exists() && ! dbFolder.canWrite() ) {
	    			throw new ConfigException(DB_DIR, "The database [" + dbFile.getAbsolutePath() + "] does not exist, and this folder is not writable.");
	    		}
	        	isValid = true;
	        	break;
	    	case SRA_ACC_LIST:
	    		Config.getExistingFile( this, SRA_ACC_LIST );
	    		isValid = true;
	    		break;
	        case SRP:
	        	List<String> ids = Config.getList( this, SRP );
	        	for (String SRP_ID : ids) {
	        		//check for SRP format, should be three letters followed by (I think) 6 numbers
	    			if ( ! SRP_ID.startsWith( "P", 2 ) || SRP_ID.length() != 9) {
	    				throw new ConfigFormatException( SRP, "SRA project id's are three letters followed by six numbers." );
	    			}
	    		}
	            isValid = true;
	            break;
	    }
	    return isValid;
	}
	
	protected static final String DB_NAME = "SRAmetadb.sqlite";
	
	protected static final String DB_DIR = "sra.metaDataDir";
	protected static final String DB_DIR_DESC = "path to the directory where the *"+DB_NAME+"* database is stored.";
	
	protected static final String SRA_ACC_LIST = "sra.sraAccList";
	protected static final String SRA_ACC_LIST_DESC = "A file that has one SRA accession per line and nothing else.";
	
	protected static final String SRP = "sra.sraProjectId";
	protected static final String SRP_DESC = "The project id(s) referencesing a project in the NCBI SRA. example: SRP009633, ERP016051";
}
