

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.context.support.ClassPathXmlApplicationContext;

import net.carefx.clinical.domain.vo.DictShearPlateVO;
import net.carefx.cpoe.domain.vo.OrderShearPlateVO;
import net.carefx.fc.common.cpoe.business.DictAndOrderSchedulingServerImpl;
import net.carefx.fc.common.cpoe.business.dict.DictTreatment;
import net.carefx.fc.common.cpoe.business.order.OrderTreatment;
import net.carefx.fc.domain.vo.FcPatientVO;
import net.carefx.pms.domain.Employee;
import net.carefx.pms.domain.Organization;

public class WebTest {
	public static void main(String[] args) throws Throwable {
		  ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[] {"classpath:META-INF/fc-root-web.spring.xml"});  
		  context.start();         
		  
		  DictAndOrderSchedulingServerImpl dictAndOrderSchedulingServerImpl = (DictAndOrderSchedulingServerImpl) context.getBean("dictAndOrderSchedulingServerImpl");
		  
		  
		  DictTreatment dictTreatment = new DictTreatment();
	        List <DictShearPlateVO> dictShearPlateVOList = new ArrayList<DictShearPlateVO>();
	        DictShearPlateVO dictShearPlateVO1 = new DictShearPlateVO ();
	        dictShearPlateVO1.setDictOrderId (13423L);
	        dictShearPlateVO1.setClinicalItemId (23388L);
	        dictShearPlateVO1.setClinicalTypeCode ("200101-0001");
	        dictShearPlateVO1.setDictOrderFeeItemId (103423L);
	        dictShearPlateVO1.setDictOrderGroupId (205L);
	        dictShearPlateVO1.setDose (1.2);
	        dictShearPlateVOList.add (dictShearPlateVO1);
	        dictTreatment.setDictShearPlateVOList (dictShearPlateVOList);
	        
	        
	        List <OrderShearPlateVO> orderShearPlateVOList;
	        OrderTreatment orderTreatment = new OrderTreatment();
	        FcPatientVO fcPatientVO = new FcPatientVO ();
	        Employee employee = new Employee ();
	        Organization organization = new Organization ();
	        fcPatientVO.setPatiId (2795L);
	        fcPatientVO.setInpatiId (2046L);
	        fcPatientVO.setInputDate (new Date ());
	        fcPatientVO.setOrgIdDiag ("178");
	        fcPatientVO.setOrgNameDiag ("心血管一病区");
	        fcPatientVO.setMrn ("832822");

	        employee.setId (new Integer (73));
	        employee.setEmpName ("丁芳宝");

	        organization.setId (new Integer (142));
	        organization.setName ("心胸外科");
	        
	        orderTreatment.setEmployee (employee);
	        orderTreatment.setOrganization (organization);
	        orderTreatment.setFcPatientVO (fcPatientVO);
	        
	        dictAndOrderSchedulingServerImpl.copyDictToOrder (dictTreatment, orderTreatment);
		  System.in.read();
	}
}
