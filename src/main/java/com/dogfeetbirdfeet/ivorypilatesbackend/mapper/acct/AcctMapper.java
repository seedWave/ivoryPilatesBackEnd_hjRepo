package com.dogfeetbirdfeet.ivorypilatesbackend.mapper.acct;

import com.dogfeetbirdfeet.ivorypilatesbackend.dto.acct.AcctDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AcctMapper {

    List<AcctDto> findAll();
}
