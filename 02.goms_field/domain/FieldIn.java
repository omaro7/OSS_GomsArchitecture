package kr.co.goms.web.oss.biz.domain;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

@Data
public class FieldIn {
    private Long fieldIdx;
    private int mbIdx;
    private int groupIdx;
    private String fieldTitle;
    private String fieldLocal;
    private Boolean useflag;
    private String regdate;
}
