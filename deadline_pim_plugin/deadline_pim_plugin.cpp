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

// deadline_pim_plugin.cpp : définit les fonctions d'initialisation pour la DLL.
//

#include "stdafx.h"
#include "db.h"
#include "deadline_pim_plugin.h"
#include "DialogDeadline.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

//
//	Remarque!
//
//		Si cette DLL est dynamiquement liée aux DLL
//		MFC, la macro AFX_MANAGE_STATE doit être ajoutée
//		au tout début des fonctions exportées
//		à partir de cette DLL qui appellent MFC.
//
//		Par exemple :
//
//		extern "C" BOOL PASCAL EXPORT ExportedFunction()
//		{
//			AFX_MANAGE_STATE(AfxGetStaticModuleState());
//			// corps de fonction normal ici
//		}
//
//		Il est très important que cette macro se trouve dans chaque
//		fonction, avant tout appel au MFC. Cela signifie qu'elle
//		doit être la première instruction dans la
//		fonction, avant toute déclaration de variable objet
//		dans la mesure où leurs constructeurs peuvent générer des appels à la DLL
//		MFC.
//
//		Consultez les notes techniques MFC 33 et 58 pour plus de
//		détails.
//

// Cdeadline_pim_pluginApp

BEGIN_MESSAGE_MAP(Cdeadline_pim_pluginApp, CWinApp)
END_MESSAGE_MAP()


// construction Cdeadline_pim_pluginApp

Cdeadline_pim_pluginApp::Cdeadline_pim_pluginApp()
{
	// TODO : ajoutez ici du code de construction,
	// Placez toutes les initialisations significatives dans InitInstance
}

// Seul et unique objet Cdeadline_pim_pluginApp

Cdeadline_pim_pluginApp theApp;

extern db_header  g_DbHeader;
extern db_record  g_DbRecords[DB_NB_RECORDS];

void Cdeadline_pim_pluginApp::CreateDatabase(const char *path)
{
  static char str[512];
  sprintf(str,"%s\\deadline_dbase_018.bin",path);
//  MessageBox(NULL,str,"Info",MB_OK);
  buildHeader();
  FILE *f=fopen(str,"wb");
  if (f != NULL)
  {
    fwrite((void *)&g_DbHeader.app_size,2,1,f);
    fwrite((void *)&g_DbHeader.db_size,2,1,f);
    fwrite((void *)&g_DbHeader.app_spec,1,1,f);
    fwrite((void *)&g_DbHeader.nb_recs,2,1,f);
    fwrite((void *)&g_DbHeader.rec_size,1,1,f);
    for (int i=0;i<DB_NB_RECORDS;i++)
    {
      fwrite((void *)&g_DbRecords[i].flags,1,1,f);
      fwrite((void *)&g_DbRecords[i].day,1,1,f);
      fwrite((void *)&g_DbRecords[i].month,1,1,f);
      fwrite((void *)&g_DbRecords[i].year_lo,1,1,f);
      fwrite((void *)&g_DbRecords[i].year_hi,1,1,f);
      strupr((char *)g_DbRecords[i].desc);
      for (int j=0;j<DESC_SIZE;j++)
      {
        unsigned char c=g_DbRecords[i].desc[j];
        if (c == '\0')
          c=10; //DM5_BLANK
        else if (c >= 'A' && c <= 'Z') 
          c=(unsigned char)((int)c-(int)'A'+11); // DM5_A == 11
        else if (c >= '0' && c <= '9') 
          c=(unsigned char)((int)c-(int)'0'+0); // DM5_0 == 0
        else
          c=10; //DM5_BLANK
        fwrite((void *)&c,1,1,f);
      }
    }
    fclose(f);
  }
  else
    MessageBox(NULL,"Unable to create database !","Error",MB_OK | MB_ICONEXCLAMATION);
}

extern "C" BOOL FAR PASCAL EXPORT Show(LPCTSTR lpszDataPath, LPVOID pData)
{
  //Need to use this macro whenever we access resources from MFC DLL
  AFX_MANAGE_STATE(AfxGetStaticModuleState());

  static char str[512];

  sprintf(str,"%s\\App",lpszDataPath);
  CDialogDeadline dlg(str);  
  int res=(int)dlg.DoModal();
  if (res == IDOK)
  {
    theApp.CreateDatabase(str);
  }
  return (res);
}

extern "C" BOOL FAR PASCAL EXPORT ProcessData(LPCTSTR lpszDataPath, LPVOID pData)
{
  //Need to use this macro whenever we access resources from MFC DLL
  AFX_MANAGE_STATE(AfxGetStaticModuleState());
  theApp.CreateDatabase(lpszDataPath);
  return TRUE;
}

// initialisation Cdeadline_pim_pluginApp

BOOL Cdeadline_pim_pluginApp::InitInstance()
{
	CWinApp::InitInstance();
  buildHeader();
  memset(g_DbRecords,0,DB_NB_RECORDS*sizeof(db_record));
//  MessageBox(NULL,"done","init",MB_OK);
	return TRUE;
}
