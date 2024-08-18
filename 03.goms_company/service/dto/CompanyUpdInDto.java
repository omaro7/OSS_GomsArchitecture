package kr.co.goms.web.oss.biz.service.dto;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import io.swagger.v3.oas.annotations.media.Schema;

@Data
@Schema(description = "Company CompanyUpdInDto")
public class CompanyUpdInDto {
    private Long comIdx;
    private String comName;
    private Boolean useflag;
    private String regdate;
}
