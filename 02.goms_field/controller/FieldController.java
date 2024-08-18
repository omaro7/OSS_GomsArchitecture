package kr.co.goms.web.oss.biz.controller;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.extern.slf4j.Slf4j;
import kr.co.goms.web.ams.mam.core.api.ApiResponse;
import kr.co.goms.web.oss.biz.service.dto.FieldIdxInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldDelInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldUpdInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldInsInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldOutDto;
import kr.co.goms.web.oss.biz.service.dto.FieldIdxOutDto;
import kr.co.goms.web.oss.biz.service.FieldService;

@Slf4j
@RestController
@RequestMapping("/api")
public class FieldController {

   private static final Logger log = LoggerFactory.getLogger(FieldController.class);

   @Autowired
   private FieldService fieldService;

   @Tag(name = "GOMS API > Field", description = "GOMS API Field�Դϴ�. ��ü ��ȸ�Դϴ�.")
   @GetMapping("/field/selectAllField")
   public ResponseEntity<ApiResponse<List<FieldOutDto>>> selectAllField() {
        List<FieldOutDto> list = fieldService.selectAllField();
        ApiResponse<List<FieldOutDto>> response = new ApiResponse<>(true, list, "success");
        return new ResponseEntity<>(response, HttpStatus.OK);
   }

   @Tag(name = "GOMS API > Field", description = "GOMS API Field�Դϴ�. ���� ��ȸ�Դϴ�.")
   @PostMapping("/field/getField")
   public ResponseEntity<ApiResponse<FieldIdxOutDto>> getField(FieldIdxInDto inDto) {
        FieldIdxOutDto  field = fieldService.getField(inDto);
        ApiResponse<FieldIdxOutDto> response = new ApiResponse<>(true, field, "success");
        return new ResponseEntity<>(response, HttpStatus.OK);
   }

   @Tag(name = "GOMS API > Field", description = "GOMS API Field�Դϴ�. ���� �����Դϴ�.")
   @PostMapping("/field/delField")
   public ResponseEntity<ApiResponse<Void>> delField(FieldDelInDto inDto) {
        boolean isDel = fieldService.delField(inDto);
        ApiResponse<Void> response;
        if (isDel) {
            response = new ApiResponse<>(true, null, "success");
        } else {
            response = new ApiResponse<>(false, null, "failure");
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
   }

   @Tag(name = "GOMS API > Field", description = "GOMS API Field�Դϴ�. ���� ������Ʈ�Դϴ�.")
   @PostMapping("/field/updField")
   public ResponseEntity<ApiResponse<Void>> updField(FieldUpdInDto inDto) {
        boolean isUpd = fieldService.updField(inDto);
        ApiResponse<Void> response;
        if (isUpd) {
            response = new ApiResponse<>(true, null, "success");
        } else {
            response = new ApiResponse<>(false, null, "failure");
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
   }

   @Tag(name = "GOMS API > Field", description = "GOMS API Field�Դϴ�. �����Դϴ�.")
   @PostMapping("/field/insField")
   public ResponseEntity<ApiResponse<Void>> insField(FieldInsInDto inDto) {
        boolean isIns= fieldService.insField(inDto);
        ApiResponse<Void> response;
        if (isIns) {
            response = new ApiResponse<>(true, null, "success");
        } else {
            response = new ApiResponse<>(false, null, "failure");
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
   }
}
