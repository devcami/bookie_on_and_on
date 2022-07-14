package com.kh.bookie.common.typehandler;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

@MappedTypes(String[].class)
@MappedJdbcTypes(JdbcType.VARCHAR)
public class StringArrayTypeHandler extends BaseTypeHandler<String[]> {

	/**
	 * String[] -> VARCHAR2
	 * null값이 아닌 값을 setting
	 */
	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType)
			throws SQLException {
		String value = String.join(",", parameter);
		ps.setString(i, value);
	}

	/**
	 * VARCHAR -> String[]
	 * nullable한 값을 String[]로 변환
	 */
	@Override
	public String[] getNullableResult(ResultSet rs, String columnName) throws SQLException {
		String value = rs.getString(columnName);
		return value != null ? value.split(",") : null;
	}

	@Override
	public String[] getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		String value = rs.getString(columnIndex);
		return value != null ? value.split(",") : null;
	}

	@Override
	public String[] getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		String value = cs.getString(columnIndex);
		return value != null ? value.split(",") : null;
	}

}
