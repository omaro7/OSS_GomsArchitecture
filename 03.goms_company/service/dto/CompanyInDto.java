package kr.co.goms.web.oss.biz.service.dto;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "Company CompanyInDto")
public class CompanyInDto {
    private Long comIdx;
    private String comName;
    private Boolean useflag;
    private String regdate;
}
