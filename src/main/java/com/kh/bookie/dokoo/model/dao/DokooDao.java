package com.kh.bookie.dokoo.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.session.RowBounds;

import com.kh.bookie.dokoo.model.dto.Dokoo;
import com.kh.bookie.dokoo.model.dto.DokooComment;
import com.kh.bookie.dokoo.model.dto.DokooSns;
import com.kh.bookie.mypage.model.dto.Book;

@Mapper
public interface DokooDao {

	List<Dokoo> selectDokooList(RowBounds rowBounds);

	int selectTotalContent();

	Dokoo selectOneDokoo(int dokooNo);

	List<DokooComment> selectDokooComments(int dokooNo);

	List<Book> getReadBookList(String memberId);

	int dokooEnroll(Dokoo dokoo);

	int commentEnroll(DokooComment dokooComment);

	int commentDel(int dokooCNo);

	int commentUpdate(DokooComment dokooComment);

	List<DokooSns> getDokooLikes(Map<String, Object> map);
	
	DokooSns getDokooBookmark(Map<String, Object> map);

	int insertDokooLike(Map<String, Object> map);

	int insertDokooWishList(Map<String, Object> map);

	int deleteDokooLike(Map<String, Object> map);

	int deleteDokooWishList(Map<String, Object> map);

	int deleteDokoo(int dokooNo);

	int updateDokoo(Dokoo dokoo);

	int commentRefEnroll(DokooComment dc);

	@Select("select * from dokoo_comment where dokooc_no = #{dokooCNo}")
	DokooComment selectOneDokooComment(int dokooCNo);

	@Delete("delete from likes_dokoo where dokoo_no = #{dokooNo}")
	int deleteDokooLikes(int dokooNo);

	@Delete("delete from wishlist_dokoo where dokoo_no = #{dokooNo}")
	int deleteDokooWishlists(int dokooNo);
	
	
}
