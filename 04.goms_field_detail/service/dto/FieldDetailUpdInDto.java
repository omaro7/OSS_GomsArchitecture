package kr.co.goms.web.oss.biz.service.dto;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import io.swagger.v3.oas.annotations.media.Schema;

@Data
@Schema(description = "FieldDetail FieldDetailUpdInDto")
public class FieldDetailUpdInDto {
    private Long fieldDetailIdx;
    private Long fieldIdx;
    private int mbIdx;
    private int fieldCode;
    private String fieldDate;
    private String fieldCoordinate;
    private String fieldAddress;
    private String mhDepth;
    private String mhInflow;
    private String mhOutflow;
    private String mhDrainage;
}
