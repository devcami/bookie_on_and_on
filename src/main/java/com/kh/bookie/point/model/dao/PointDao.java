package com.kh.bookie.point.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.kh.bookie.point.model.dto.PointStatus;

@Mapper
public interface PointDao {

	int insertPoint(PointStatus pointStatus);

	@Select("select point from member where member_Id = #{memberId}")
	int getMemberPoint(String memberId);

	@Update("update point_status set total_point = #{totalPoint} where point_no = #{pointNo}")
	int updateTotalPointInPointStatus(PointStatus pointStatus);

	@Update("update member set point = #{totalPoint} where member_id = #{memberId}")
	int updateTotalPointInMember(PointStatus pointStatus);

	List<PointStatus> getMyPointStatusList(Map<String, Object> map);
	

	

}
