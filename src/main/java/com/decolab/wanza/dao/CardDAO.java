package com.decolab.wanza.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.decolab.wanza.dto.CardDTO;
import com.decolab.wanza.dto.CardReviewDTO;

@Mapper
@Repository
public interface CardDAO {

	public List<CardDTO> getCardList();
	
	public int cardWrite(CardDTO dto);
	
	public int addCardReadCount(CardDTO dto);
	
	public int getLikeCount(CardDTO dto);
	public int boolLike(CardDTO dto);
	public int addCardLikeCount(CardDTO dto);
	public int deleteCardLikeCount(CardDTO dto);
	
	public List<CardReviewDTO> getCardReviewList(CardReviewDTO dto);
	
	public int getCardReviewCount(CardReviewDTO dto);
	
	public int cardReviewWrite(CardReviewDTO dto);
	
}
