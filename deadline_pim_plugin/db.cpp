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

#include <memory.h>
#include "db.h"

db_header g_DbHeader;
db_record g_DbRecords[DB_NB_RECORDS];

void buildHeader()
{
  g_DbHeader.db_size=SIZEOF_HEADER+DB_NB_RECORDS*SIZEOF_RECORD;
  g_DbHeader.app_size=((((g_DbHeader.db_size-1))/64)+1)*64;
  g_DbHeader.app_spec=3;
  g_DbHeader.nb_recs=DB_NB_RECORDS;
  g_DbHeader.rec_size=SIZEOF_RECORD;
}
