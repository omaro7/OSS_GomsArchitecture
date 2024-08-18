package kr.co.goms.web.oss.biz.service.dto;

import java.util.Date;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import io.swagger.v3.oas.annotations.media.Schema;

@Data
@Schema(description = "Group GroupInsInDto")
public class GroupInsInDto {
    private Long groupIdx;
    private int mbIdx;
    private String groupName;
    private Boolean useflag;
    private String regdate;
}
