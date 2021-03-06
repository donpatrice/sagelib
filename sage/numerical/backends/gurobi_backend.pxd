##############################################################################
#       Copyright (C) 2010 Nathann Cohen <nathann.cohen@gmail.com>
#  Distributed under the terms of the GNU General Public License (GPL)
#  The full text of the GPL is available at:
#                  http://www.gnu.org/licenses/
##############################################################################

from generic_backend cimport GenericBackend
include '../../../../../devel/sage/sage/ext/stdsage.pxi'


#cdef extern from *:
#    ctypedef double* const_double_ptr "const double*"
#    ctypedef char * const_char_ptr "const char*"

#cdef extern from "float.h":
#    cdef double DBL_MAX

cdef extern from "../../../local/include/gurobi_c.h":
     ctypedef struct GRBmodel:
         pass
     ctypedef struct GRBenv:
         pass

     int GRBloadenv(GRBenv **, char *)
     int GRBnewmodel(GRBenv *env, GRBmodel **modelP, char *Pname, int numvars, double *obj, double *lb, double *ub, char *vtype, char **varnames)
     int GRBaddvar(GRBmodel *model, int numnz, int *vind, double *vval, double obj, double lb, double ub, char vtype, char *varname)
     int GRBaddvars (GRBmodel*model, intnumvars, intnumnz, int*vbeg, int*vind, double*vval, double*obj, double*lb, double*ub, char*vtype, char** varnames )



     int GRBaddconstr(GRBmodel *model, int numnz, int *cind, double *cval, char sense, double rhs, char *constrnames)

     int GRBdelconstrs (GRBmodel *model, int numdel, int * ind )
     int GRBaddrangeconstr(GRBmodel *model, int numnz, int *cind, double *cval, double lower, double upper, char *constrnames)


     void GRBfreemodel(GRBmodel *model)
     void GRBfreeenv(GRBenv *env)
     int GRBupdatemodel(GRBmodel *model)
     int GRBoptimize(GRBmodel *model)
     char * GRBgeterrormsg(GRBenv *env)
     int GRBgetintattr(GRBmodel *model, char * attrname, int * result)
     int GRBsetintattr(GRBmodel *model, char * attrname, int value)

     int GRBgetdblattr(GRBmodel *model, char * attrname, double * result)
     int GRBsetdblattr(GRBmodel *model, char * attrname, double value)

     int GRBgetdblattrelement (GRBmodel*model, char* attrname, int element, double* valueP )
     int GRBsetdblattrelement (GRBmodel*model, char* attrname, int element, double valueP )

     int GRBgetcharattrelement (GRBmodel*model, char* attrname, int element, char* valueP )
     int GRBsetcharattrelement (GRBmodel*model, char* attrname, int element, char valueP )
     int GRBsetstrattr (GRBmodel*model, char* attrname, char * valueP )
     int GRBgetstrattr (GRBmodel*model, char* attrname, char ** valueP )

     #int GRBsetstrattrelement (GRBmodel*model, char* attrname, int index, char * valueP )
     int GRBgetstrattrelement (GRBmodel*model, char* attrname, int index, char ** valueP )


     int GRBwrite (GRBmodel*model, char* filename)

     int GRBsetintparam(GRBenv *env, char * attrname, int value)

     GRBenv * GRBgetenv (GRBmodel * model )


     int GRBgetconstrs (GRBmodel * model, int * numnzP, int * cbeg, int * cind, double * cval, int start, int len )

     int GRB_BINARY
     int GRB_CONTINUOUS
     int GRB_INTEGER
     int GRB_INFINITY

     char GRB_LESS_EQUAL
     char GRB_GREATER_EQUAL
     char GRB_EQUAL

     int GRB_LOADED
     int GRB_OPTIMAL
     int GRB_INFEASIBLE
     int GRB_INF_OR_UNBD
     int GRB_UNBOUNDED
     int GRB_CUTOFF
     int GRB_ITERATION_LIMIT
     int GRB_NODE_LIMIT
     int GRB_TIME_LIMIT
     int GRB_SOLUTION_LIMIT
     int GRB_INTERRUPTED
     int GRB_NUMERIC
     int GRB_SUBOPTIMAL




cdef class GurobiBackend(GenericBackend):

    cdef GRBenv * env
    cdef GRBmodel ** model

    cdef int num_vars


