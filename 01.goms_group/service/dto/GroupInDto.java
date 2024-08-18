package kr.co.goms.web.oss.biz.service.dto;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Schema(description = "Group GroupInDto")
public class GroupInDto {
    private Long groupIdx;
    private int mbIdx;
    private String groupName;
    private Boolean useflag;
    private String regdate;
}
