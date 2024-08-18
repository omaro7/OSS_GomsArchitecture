package kr.co.goms.web.oss.biz.service;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryIdxInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryDelInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryUpdInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryInsInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryOutDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryIdxOutDto;
import kr.co.goms.web.oss.biz.repository.FieldCategoryRepository;

@Service
@Transactional
public class  FieldCategoryService {

   private final Logger log = LoggerFactory.getLogger(FieldCategoryService.class);

   @Autowired FieldCategoryRepository field_categoryRepository;

    public List<FieldCategoryOutDto> selectAllFieldCategory(){
        FieldCategoryInDto inDto = new FieldCategoryInDto();
        List<FieldCategoryOutDto> list = null;
        list = field_categoryRepository.selectAllFieldCategory(inDto);
        return list;
   }

    public FieldCategoryIdxOutDto getFieldCategory(FieldCategoryIdxInDto inDto){
        FieldCategoryIdxOutDto field_category = null;
        field_category = field_categoryRepository.getFieldCategory(inDto);
        return field_category;
   }

    public boolean delFieldCategory(FieldCategoryDelInDto inDto){
        boolean isDel = field_categoryRepository.delFieldCategory(inDto);
        return isDel;
   }

    public boolean updFieldCategory(FieldCategoryUpdInDto inDto){
        boolean isUpd = field_categoryRepository.updFieldCategory(inDto);
        return isUpd;
   }

    public boolean insFieldCategory(FieldCategoryInsInDto inDto){
        boolean isIns = field_categoryRepository.insFieldCategory(inDto);
        return isIns;
   }
}
