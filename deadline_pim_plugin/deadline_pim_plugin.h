// deadline_pim_plugin.h : fichier d'en-tête principal pour la DLL deadline_pim_plugin
//


#pragma once

#ifndef __AFXWIN_H__
	#error include 'stdafx.h' before including this file for PCH
#endif

#include "resource.h"		// symboles principaux


// Cdeadline_pim_pluginApp
// Consultez deadline_pim_plugin.cpp pour l'implémentation de cette classe
//

class Cdeadline_pim_pluginApp : public CWinApp
{
public:
	Cdeadline_pim_pluginApp();
  void CreateDatabase(const char *);

// Overrides
public:
	virtual BOOL InitInstance();

	DECLARE_MESSAGE_MAP()
};
