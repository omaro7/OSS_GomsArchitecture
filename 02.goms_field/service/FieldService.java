package kr.co.goms.web.oss.biz.service;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import kr.co.goms.web.oss.biz.service.dto.FieldInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldIdxInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldDelInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldUpdInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldInsInDto;
import kr.co.goms.web.oss.biz.service.dto.FieldOutDto;
import kr.co.goms.web.oss.biz.service.dto.FieldIdxOutDto;
import kr.co.goms.web.oss.biz.repository.FieldRepository;

@Service
@Transactional
public class  FieldService {

   private final Logger log = LoggerFactory.getLogger(FieldService.class);

   @Autowired FieldRepository fieldRepository;

    public List<FieldOutDto> selectAllField(){
        FieldInDto inDto = new FieldInDto();
        List<FieldOutDto> list = null;
        list = fieldRepository.selectAllField(inDto);
        return list;
   }

    public FieldIdxOutDto getField(FieldIdxInDto inDto){
        FieldIdxOutDto field = null;
        field = fieldRepository.getField(inDto);
        return field;
   }

    public boolean delField(FieldDelInDto inDto){
        boolean isDel = fieldRepository.delField(inDto);
        return isDel;
   }

    public boolean updField(FieldUpdInDto inDto){
        boolean isUpd = fieldRepository.updField(inDto);
        return isUpd;
   }

    public boolean insField(FieldInsInDto inDto){
        boolean isIns = fieldRepository.insField(inDto);
        return isIns;
   }
}
