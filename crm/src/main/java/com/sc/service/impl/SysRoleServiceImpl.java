package com.sc.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sc.entity.SysRole;
import com.sc.entity.SysRoleExample;
import com.sc.entity.SysRoleExample.Criteria;
import com.sc.entity.SysUsers;
import com.sc.mapper.SysRoleMapper;
import com.sc.mapper.SysUsersMapper;
import com.sc.service.SysRoleService;

@Service
public class SysRoleServiceImpl implements SysRoleService {

	@Autowired
	SysRoleMapper sysRoleMapper;
	
	@Autowired
	SysUsersMapper sysUsersMapper;
	
	@Override
	public void addRole(SysRole sr) {
		if(sr!=null){
			this.sysRoleMapper.insert(sr);
		}
		
	}

	@Override
	public List<SysRole> selectAll() {
		List<SysRole> list = this.sysRoleMapper.selectByExample(null);
		return list;
	}

	@Override
	public List<SysRole> selectBySuperId(long sId) {
		SysRoleExample example = new SysRoleExample();
		Criteria criteria = example.createCriteria();
		criteria.andSuperRoleIdEqualTo(sId);
		List<SysRole> sonList = this.sysRoleMapper.selectByExample(example);
		return sonList;
	}

	@Override
	public SysRole selectByPK(long pk) {
		
			SysRole role = this.sysRoleMapper.selectByPrimaryKey(pk);
		    return role;
	}

	@Override
	public SysRole selectMeAndSuper(Long rId) {
		SysRole role = this.sysRoleMapper.selectMeAndSuper(rId);
		return role;
	}

	@Override
	public PageInfo<SysRole> selectUsers(Integer pageNum,Integer pageSize,Long rId) {
		PageHelper.startPage(pageNum, pageSize);
		List<SysRole> list = this.sysRoleMapper.selectUsers(rId);
		PageInfo<SysRole> info = new PageInfo<SysRole>(list);
		return info;
	}

	@Override
	public PageInfo<SysUsers> selectUsersAndNORoleUser(Integer pageNum, Integer pageSize, Long rId) {
		PageHelper.startPage(pageNum, pageSize);
		/*List<SysRole> list = this.sysRoleMapper.selectUsersAndInfos(22L);
		for (SysRole sysRole : list) {
			for (SysUsers sysUsers : sysRole.getSysUsers()) {
				System.out.println(sysRole.toString()+":"+sysUsers.toString()
						+":"+sysUsers.getSysUserinfo().toString());
			}
		}*/
		PageHelper.startPage(pageNum, pageSize);
		ArrayList<SysUsers> list = new ArrayList<SysUsers>();
		List<Long> list1=new ArrayList<Long>();
		
		SysUsers user = this.sysUsersMapper.selectRole(rId);
		long sId=user.getSysRole().getRoleId();
		list1.add(sId);
		for (int i = 0; i < list1.size(); i++) {
			List<SysRole> sonList = this.selectBySuperId(list1.get(i));
			for (SysRole sysRole : sonList) {
				list1.add(sysRole.getRoleId());
			}
		}
		System.out.println(list1.size());
		list1.remove(0);
		/*�������м����ӽ�ɫ�ĳ�Ա*/
		for (Long l : list1) {
			List<SysRole> sr = this.sysRoleMapper.selectUsersAndInfos(l);
			for (SysRole sysRole : sr) {
				for (SysUsers sysUsers : sysRole.getSysUsers()) {
					list.add(sysUsers);
				}
			}
		}
		/*�������м����޽�ɫ�ĳ�Ա*/
		List<SysUsers> list2 = this.sysUsersMapper.selectNoRoleUser();
		for (SysUsers sysUsers : list2) {
			list.add(sysUsers);
		}
		System.out.println(list.size()+"��");
		for (SysUsers sysUsers : list) {
			System.out.println(sysUsers.toString()+":"+sysUsers.getSysUserinfo().toString());
		}
		PageInfo<SysUsers> info = new PageInfo<SysUsers>(list);
		return info;
	}

}