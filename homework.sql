--  Q1. ������̺�(EMP)���� �Ի���(HIREDATE)�� 4�ڸ� ������ ��� 
--      �ǵ��� SQL���� �ۼ��ϼ���? (ex. 1980/01/01)
select to_char(hiredate, 'YYYY-MM-DD') from emp;

--Q2. ������̺�(EMP)���� MGR�÷���  ����  null �� �������� MGR�� 
--    ����  CEO ��  ����ϴ� SQL���� �ۼ� �ϼ���?
select TO_CHAR(NULL) "Warehouse" from emp;

select * from emp;