package pm.insa.com.vo;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;

	public class UploadFileUtils {
		private static final Logger logger =
			      LoggerFactory.getLogger(UploadFileUtils.class);


			  public static String uploadFile(String uploadPath, String originalName, byte[] fileData)
					  																		throws Exception{

			    UUID uid = UUID.randomUUID();

			    String savedName = uid.toString() +"_"+originalName;

			    String savedPath = calcPath(uploadPath);  //경로계산

			    File target = new File(uploadPath +savedPath,savedName);
			    				//	File(parent, child)

			    FileCopyUtils.copy(fileData, target);		//fileData를 target으로 복사

			    String formatName = originalName.substring(originalName.lastIndexOf(".")+1);		//확장자

			    String uploadedFileName = null;

			    if(MediaUtils.getMediaType(formatName) != null){
			      uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName);
			    }else{
			      uploadedFileName = makeIcon(uploadPath, savedPath, savedName);
			    }

			    return uploadedFileName;

			  }

			  private static  String makeIcon(String uploadPath,
			      String path,
			      String fileName)throws Exception{

			    String iconName =
			        uploadPath + path + File.separator+ fileName;

			    return iconName.substring(
			        uploadPath.length()).replace(File.separatorChar, '/');
			  }


			  private static  String makeThumbnail(
			              String uploadPath,
			              String path,
			              String fileName)throws Exception{

			    BufferedImage sourceImg =
			        ImageIO.read(new File(uploadPath + path, fileName));
			    String thumbnailName =
			        uploadPath + path + File.separator +"s_"+ fileName;

			    File newFile = new File(thumbnailName);
			    String formatName =
			        fileName.substring(fileName.lastIndexOf(".")+1);


			    ImageIO.write(sourceImg, formatName.toUpperCase(), newFile);
			    return thumbnailName.substring(
			        uploadPath.length()).replace(File.separatorChar, '/');
			  }


			  private static String calcPath(String uploadPath){

			    Calendar cal = Calendar.getInstance();

			    String yearPath = File.separator+cal.get(Calendar.YEAR);

			    String monthPath = yearPath +
			        File.separator +
			        new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);

			    String datePath = monthPath +
			        File.separator +
			        new DecimalFormat("00").format(cal.get(Calendar.DATE));

			    makeDir(uploadPath, yearPath,monthPath,datePath);

			    logger.info(datePath);

			    return datePath;
			  }


			  private static void makeDir(String uploadPath, String... paths){

			    if(new File(paths[paths.length-1]).exists()){
			      return;
			    }

			    for (String path : paths) {

			      File dirPath = new File(uploadPath + path);

			      if(! dirPath.exists() ){
			        dirPath.mkdir();
			      }
			    }
			  }
	}
