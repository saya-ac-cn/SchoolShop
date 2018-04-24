package api.controller;

import api.entity.AdminEntity;
import api.entity.StudentEntity;
import api.entity.UserEntity;
import api.service.impl.PublicServiceImpl;
import api.tools.Result;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

/**
 * 公共处理接口
 */
@RestController
@RequestMapping(value = "/api/public")
public class PublicController {

    @Autowired
    @Qualifier("publicService")
    private PublicServiceImpl publicService;

    /**
     * 查询该商户管理员是否存在
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/studentExist.yht")
    public Result<Integer> studentExist(StudentEntity vo) throws Exception
    {
        return publicService.studentExist(vo);
    }

    /**
     * 商户管理员注册
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/studentRegister.yht")
    public Result<Integer> studentRegister(StudentEntity vo) throws Exception
    {
        return publicService.studentRegister(vo);
    }

    /**
     * 商户管理员登录
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/studentLogin.yht")
    public Result<Integer> studentLogin(StudentEntity vo) throws Exception
    {
        return publicService.studentLogin(vo);
    }

    /**
     * 管理员登录
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/adminLogin.yht")
    public Result<Integer> studentLogin(AdminEntity vo) throws Exception
    {
        return publicService.adminLogin(vo);
    }

    /**
     * 判断会员用户是否存在
     * @param username
     * @return
     * @throws Exception
     */
    @GetMapping(value = "/userExist.yht")
    public Result<Integer>  userExist(@RequestParam("username")String username) throws Exception
    {
        return publicService.userExist(username);
    }

    /**
     * 会员用户登录
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "/userLogin.yht")
    public Result<Integer> userLogin(UserEntity vo) throws Exception
    {
        return publicService.userLogin(vo);
    }

    /**
     * 用户注册
     * @param vo
     * @return
     * @throws Exception
     */
    @PostMapping(value = "userRegister.yht")
    public Result<Integer> userRegister(UserEntity vo)throws Exception
    {
        return publicService.userRegister(vo);
    }


    @GetMapping(value = "/export")
    public void export(HttpServletRequest request, HttpServletResponse response) throws Exception
    {
        //第一行字段名
        String[] title = {"id","user","type","date"};
        //创建Excel工作簿
        HSSFWorkbook workbook = new HSSFWorkbook();
        //创建Excel工作表
        HSSFSheet sheet = workbook.createSheet();
        //创建第一行
        HSSFRow row = sheet.createRow(0);
        HSSFCell cell = null;
        //插入第二行字段名
        for(int i = 0;i < title.length;i++)
        {
            cell = row.createCell(i);
            cell.setCellValue(title[i]);
        }
        //插入数据
        for(int i = 1;i <= 10;i++)
        {
            HSSFRow nextrow = sheet.createRow(i);
            //第一列
            HSSFCell dataCell = nextrow.createCell(0);
            dataCell.setCellValue(i);
            //第二列
            dataCell = nextrow.createCell(1);
            dataCell.setCellValue("Pandora");
            //第三列
            dataCell = nextrow.createCell(2);
            dataCell.setCellValue("Ox001");
            //第四列
            dataCell = nextrow.createCell(3);
            dataCell.setCellValue("2018-01-29 12:12:12");
        }
        try {
            String downFileName = new String("省份.xls");
            // 清空response
            response.reset();
            response.setContentType("application/msexcel");//设置生成的文件类型
            response.setCharacterEncoding("UTF-8");//设置文件头编码方式和文件名
            response.setHeader("Content-Disposition", "attachment; filename=" + new String(downFileName.getBytes("utf-8"), "ISO8859-1"));

            OutputStream out = response.getOutputStream();
            workbook.write(out);
            out.flush();
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
