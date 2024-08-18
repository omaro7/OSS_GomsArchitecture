package kr.co.goms.web.oss.biz.repository;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryIdxInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryDelInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryUpdInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryInsInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryOutDto;
import kr.co.goms.web.oss.biz.service.dto.FieldCategoryIdxOutDto;

@Mapper 
@Repository
public interface  FieldCategoryRepository {
    public List<FieldCategoryOutDto> selectAllFieldCategory(FieldCategoryInDto inDto);
    public FieldCategoryIdxOutDto  getFieldCategory(FieldCategoryIdxInDto inDto);
    public boolean  delFieldCategory(FieldCategoryDelInDto inDto);
    public boolean  updFieldCategory(FieldCategoryUpdInDto inDto);
    public boolean  insFieldCategory(FieldCategoryInsInDto inDto);
}
