package api.tools;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

/**
 * 文件操作助手类
 */
public class FileOperate {


    /**
     * 随机生成文件名
     * @return
     */
    public static String generateRandomFilename(){
        String RandomFilename = "";
        Random rand = new Random();//生成随机数
        int random = rand.nextInt();

        Calendar calCurrent = Calendar.getInstance();
        int intDay = calCurrent.get(Calendar.DATE);
        int intMonth = calCurrent.get(Calendar.MONTH) + 1;
        int intYear = calCurrent.get(Calendar.YEAR);
        String now = String.valueOf(intYear) + "_" + String.valueOf(intMonth) + "_" +
                String.valueOf(intDay) + "_";
        RandomFilename = now + String.valueOf(random > 0 ? random : ( -1) * random) + ".";
        return RandomFilename;
    }

    /**
     * 删除图片
     * @param request
     * @param url
     */
    public static void deletePicture(HttpServletRequest request,String url)
    {
        String tempurl = request.getServletContext().getRealPath("/")+url;
        File deletefile=new File(tempurl);
        if(deletefile.exists() && deletefile.isFile())//判断要删除的目录是否存在
        {
            deletefile.delete();//执行删除
        }
    }

}
