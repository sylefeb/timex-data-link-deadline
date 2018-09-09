/*
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;    Copyright (C) 2003 Sylvain Lefebvre
;
;    This program is free software; you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation; (version 2)
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program; if not, write to the Free Software
;    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
*/

#include "stdafx.h"
#include "deadline_pim_plugin.h"
#include "DialogDeadline.h"

#include "db.h"

extern db_header  g_DbHeader;
extern db_record  g_DbRecords[DB_NB_RECORDS];

// Boîte de dialogue CDialogDeadline

IMPLEMENT_DYNAMIC(CDialogDeadline, CDialog)
CDialogDeadline::CDialogDeadline(CWnd* pParent /*=NULL*/)
: CDialog(CDialogDeadline::IDD, pParent)
{

}

CDialogDeadline::CDialogDeadline(const char *path,CWnd* pParent)
: CDialog(CDialogDeadline::IDD, pParent)
{
  m_Path=std::string(path);
}

CDialogDeadline::~CDialogDeadline()
{
}

void CDialogDeadline::DoDataExchange(CDataExchange* pDX)
{
  CDialog::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CDialogDeadline, CDialog)
  ON_BN_CLICKED(IDOK, OnBnClickedOk)
END_MESSAGE_MAP()

#define ENCODE(x) (((x) % 10)+(((x)/10) % 10)*16)
#define DECODE(x) (((x) % 16)+(((x)/16) % 16)*10)

static int tbl_ed[DB_NB_RECORDS]={
                     IDC_EDIT1,
                     IDC_EDIT2,
                     IDC_EDIT3,
                     IDC_EDIT4,
                     IDC_EDIT5,
                     IDC_EDIT6,
                     IDC_EDIT7,
                     IDC_EDIT8,
                     IDC_EDIT9,
                     IDC_EDIT10,
                     IDC_EDIT11,
                     IDC_EDIT12,
                     IDC_EDIT13,
                     IDC_EDIT14,
                     IDC_EDIT15,
                     IDC_EDIT16,
                     IDC_EDIT17,
                     IDC_EDIT18,
                     IDC_EDIT19,
                     IDC_EDIT20
};

static int tbl_dt[DB_NB_RECORDS]={
                     IDC_DATETIMEPICKER1,
                     IDC_DATETIMEPICKER2,
                     IDC_DATETIMEPICKER3,
                     IDC_DATETIMEPICKER4,
                     IDC_DATETIMEPICKER5,
                     IDC_DATETIMEPICKER6,
                     IDC_DATETIMEPICKER7,
                     IDC_DATETIMEPICKER8,
                     IDC_DATETIMEPICKER9,
                     IDC_DATETIMEPICKER10,
                     IDC_DATETIMEPICKER11,
                     IDC_DATETIMEPICKER12,
                     IDC_DATETIMEPICKER13,
                     IDC_DATETIMEPICKER14,
                     IDC_DATETIMEPICKER15,
                     IDC_DATETIMEPICKER16,
                     IDC_DATETIMEPICKER17,
                     IDC_DATETIMEPICKER18,
                     IDC_DATETIMEPICKER19,
                     IDC_DATETIMEPICKER20
};

void CDialogDeadline::FillDB()
{
  CEdit         *ed;
  CDateTimeCtrl *dt;
  SYSTEMTIME     date;
  FILE          *f;
  static char    str[256];

  sprintf(str,"%s\\deadline.db",m_Path.c_str());
  f=fopen(str,"w");
  for (int n=0;n<DB_NB_RECORDS;n++)
  {
    dt = reinterpret_cast<CDateTimeCtrl *>(GetDlgItem(tbl_dt[n]));
    dt->GetTime(&date);
    g_DbRecords[n].day=ENCODE(date.wDay);
    g_DbRecords[n].month=ENCODE(date.wMonth);
    g_DbRecords[n].year_lo=ENCODE(date.wYear % 100);
    g_DbRecords[n].year_hi=ENCODE(date.wYear / 100);

    ed=reinterpret_cast<CEdit *>(GetDlgItem(tbl_ed[n]));
    ed->GetLine(0,(char *)g_DbRecords[n].desc,DESC_SIZE);

    g_DbRecords[n].flags=(g_DbRecords[n].desc[0] != '\0')?1:0;

    if (f != NULL)
    {
      fprintf(f,"%d %d %d %d",
        g_DbRecords[n].day,
        g_DbRecords[n].month,
        g_DbRecords[n].year_lo,
        g_DbRecords[n].year_hi);
      for (int i=0;i<DESC_SIZE;i++)
        fprintf(f," %d",g_DbRecords[n].desc[i]);
      fprintf(f,"\n");
    }
  }
  if (f != NULL)
    fclose(f);
}

BOOL CDialogDeadline::OnInitDialog() 
{

  // set limits
  CEdit *ed;

  for (int i=0;i<DB_NB_RECORDS;i++)
  {
    ed=reinterpret_cast<CEdit *>(GetDlgItem(tbl_ed[i]));
    ed->SetLimitText(DESC_SIZE);
  }

  // load 

  FILE *f;
  static char str[256];

  sprintf(str,"%s\\deadline.db",m_Path.c_str());
  f=fopen(str,"r");
  if (f != NULL)
  {
    for (int n=0;n<DB_NB_RECORDS;n++)
    {
      fscanf(f,"%d %d %d %d",
        &g_DbRecords[n].day,
        &g_DbRecords[n].month,
        &g_DbRecords[n].year_lo,
        &g_DbRecords[n].year_hi);

      for (int i=0;i<DESC_SIZE;i++)
      {
        int c;
        fscanf(f,"%d",&c);
        g_DbRecords[n].desc[i]=(char)c;
      }

      CEdit         *ed;
      CDateTimeCtrl *dt;

      dt = reinterpret_cast<CDateTimeCtrl *>(GetDlgItem(tbl_dt[n]));
      CTime date(DECODE(g_DbRecords[n].year_lo)+DECODE(g_DbRecords[n].year_hi)*100,
        DECODE(g_DbRecords[n].month),
        DECODE(g_DbRecords[n].day),0,0,0);
      dt->SetTime(&date);

      ed=reinterpret_cast<CEdit *>(GetDlgItem(tbl_ed[n]));
      for (int i=0;i<DESC_SIZE;i++)
        str[i]=g_DbRecords[n].desc[i];
      str[i]='\0';
      ed->SetWindowText(_T(str));
    }
    fclose(f);
  }
  return (TRUE);
}

void CDialogDeadline::OnBnClickedOk()
{
  FillDB();
  OnOK();
}
