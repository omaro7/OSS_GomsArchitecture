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
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryIdxInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryDelInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryUpdInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryInsInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryOutDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryIdxOutDto;
import kr.co.goms.web.oss.biz.service.FieldCategoryService;

@Slf4j
@RestController
@RequestMapping("/api")
public class FieldCategoryController {

   private static final Logger log = LoggerFactory.getLogger(FieldCategoryController.class);

   @Autowired
   private FieldCategoryService field_categoryService;

   @Tag(name = "GOMS API > FieldCategory", description = "GOMS API FieldCategory�Դϴ�. ��ü ��ȸ�Դϴ�.")
   @GetMapping("/field_category/selectAllFieldCategory")
   public ResponseEntity<ApiResponse<List<FieldCategoryOutDto>>> selectAllFieldCategory() {
        List<FieldCategoryOutDto> list = field_categoryService.selectAllFieldCategory();
        ApiResponse<List<FieldCategoryOutDto>> response = new ApiResponse<>(true, list, "success");
        return new ResponseEntity<>(response, HttpStatus.OK);
   }

   @Tag(name = "GOMS API > FieldCategory", description = "GOMS API FieldCategory�Դϴ�. ���� ��ȸ�Դϴ�.")
   @PostMapping("/field_category/getFieldCategory")
   public ResponseEntity<ApiResponse<FieldCategoryIdxOutDto>> getFieldCategory(FieldCategoryIdxInDto inDto) {
        FieldCategoryIdxOutDto  field_category = field_categoryService.getFieldCategory(inDto);
        ApiResponse<FieldCategoryIdxOutDto> response = new ApiResponse<>(true, field_category, "success");
        return new ResponseEntity<>(response, HttpStatus.OK);
   }

   @Tag(name = "GOMS API > FieldCategory", description = "GOMS API FieldCategory�Դϴ�. ���� �����Դϴ�.")
   @PostMapping("/field_category/delFieldCategory")
   public ResponseEntity<ApiResponse<Void>> delFieldCategory(FieldCategoryDelInDto inDto) {
        boolean isDel = field_categoryService.delFieldCategory(inDto);
        ApiResponse<Void> response;
        if (isDel) {
            response = new ApiResponse<>(true, null, "success");
        } else {
            response = new ApiResponse<>(false, null, "failure");
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
   }

   @Tag(name = "GOMS API > FieldCategory", description = "GOMS API FieldCategory�Դϴ�. ���� ������Ʈ�Դϴ�.")
   @PostMapping("/field_category/updFieldCategory")
   public ResponseEntity<ApiResponse<Void>> updFieldCategory(FieldCategoryUpdInDto inDto) {
        boolean isUpd = field_categoryService.updFieldCategory(inDto);
        ApiResponse<Void> response;
        if (isUpd) {
            response = new ApiResponse<>(true, null, "success");
        } else {
            response = new ApiResponse<>(false, null, "failure");
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
   }

   @Tag(name = "GOMS API > FieldCategory", description = "GOMS API FieldCategory�Դϴ�. �����Դϴ�.")
   @PostMapping("/field_category/insFieldCategory")
   public ResponseEntity<ApiResponse<Void>> insFieldCategory(FieldCategoryInsInDto inDto) {
        boolean isIns= field_categoryService.insFieldCategory(inDto);
        ApiResponse<Void> response;
        if (isIns) {
            response = new ApiResponse<>(true, null, "success");
        } else {
            response = new ApiResponse<>(false, null, "failure");
        }
        return new ResponseEntity<>(response, HttpStatus.OK);
   }
}
