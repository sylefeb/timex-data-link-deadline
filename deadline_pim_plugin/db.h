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

#ifndef __DB_WRISTAPP__
#define __DB_WRISTAPP__

#include <windows.h>
#define DB_NB_RECORDS 20

typedef struct s_db_header
{
  SHORT app_size;
  SHORT db_size;
  BYTE  app_spec;
  SHORT nb_recs;
  BYTE  rec_size;
}db_header;

#define SIZEOF_HEADER 8

#define DESC_SIZE 8

typedef struct s_db_record
{
  BYTE  flags;
  BYTE  day;
  BYTE  month;
  BYTE  year_lo;
  BYTE  year_hi;
  BYTE  desc[DESC_SIZE];
}db_record;

#define SIZEOF_RECORD (5+DESC_SIZE)

void buildHeader();

#endif
