package biolockj.module.getData.sra;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import biolockj.Config;
import biolockj.Properties;
import biolockj.api.ApiModule;
import biolockj.util.BioLockJUtil;

public class SrpSrrConverter extends SequenceReadArchive implements ApiModule {
	
	public SrpSrrConverter() {
		addNewProperty( SRP, Properties.LIST_TYPE, SRP_DESC);
		addGeneralProperty( EXE_ESEARCH );
		addGeneralProperty( EXE_EFETCH );
		addGeneralProperty( EXE_XTRACT );
	}

	@Override
	public String getDockerImageName() {
		return "edirect";
	}
	
	@Override
	public String getDockerImageOwner() {
		return "ncbi";
	}

	@Override
	public String getDockerImageTag() {
		return "latest";
	}
	
	@Override
	public List<String> getWorkerScriptFunctions() throws Exception {
		List<String> lines = new ArrayList<>();
		lines.add( "function " + FUNCTION_NAME + "() {" );
		lines.add( "# $1 - Sra project id, SRP######" );
		lines.add( "# $2 - output file" );
		// "esearch -db sra -query $1 | efetch -format native | xtract -pattern IDENTIFIERS -element PRIMARY_ID  | grep RR > $2"
		lines.add( Config.getExe( this, EXE_ESEARCH ) + " -db sra -query $1 | " 
						+ Config.getExe( this, EXE_EFETCH ) + " -format native | " 
						+ Config.getExe( this, EXE_XTRACT ) + " -pattern IDENTIFIERS -element PRIMARY_ID  | "
						+ Config.getExe( this, "exe.grep" ) + " RR >> $2" );
		lines.add( "}" );
		return lines;
	}

	@Override
	public List<List<String>> buildScript( List<File> files ) throws Exception {
		List<List<String>> outer = new ArrayList<>();
		List<String> inner = new ArrayList<>();
		File outFile = new File(getOutputDir(), ACC_FILE_NAME);
		for (String srpId : Config.getList( this, SRP )) {
			inner.add( FUNCTION_NAME + " " + srpId + " " + outFile.getAbsolutePath() );
		}
		outer.add( inner );
		return outer;
	}
	
	@Override
	public void cleanUp() throws Exception {
		super.cleanUp();
		Config.setFilePathProperty( SRA_ACC_LIST, new File(getOutputDir(), ACC_FILE_NAME).getAbsolutePath() );
	}

	@Override
	public String getDescription() {
		return "Create an SraAccList.txt file from an SRA project identifier.";
	}
	
	@Override
	public String getDetails() {
		return "Typcially, this module is only added to the pipeline when " + SraDownload.class.getSimpleName() + " needs it.<br>"
						+ System.lineSeparator() + "This sets the value of *" + SRA_ACC_LIST + "* to the " + ACC_FILE_NAME + " file in this modules output directory" ;
	}

	@Override
	public String getCitationString() {
		return "Module developed by Malcolm Zapatas and Ivory Blakley" + System.lineSeparator()
						+ "BioLockJ " + BioLockJUtil.getVersion();
	}
	
	private static final String FUNCTION_NAME = "main";
	private static final String EXE_ESEARCH = "exe.esearch";
	private static final String EXE_EFETCH = "exe.efetch";
	private static final String EXE_XTRACT = "exe.xtract";
	private static final String ACC_FILE_NAME = "SraAccList.txt";

}
