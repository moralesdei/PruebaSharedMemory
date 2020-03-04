#include <Python.h>
#include "CL/opencl.h"

static PyObject* helloworld(PyObject* self) {
   return Py_BuildValue("s", "Hello, Deimer !!");
}

static char helloworld_docs[] =
   "helloworld( ): Any message you want to put here!!\n";

static PyMethodDef helloworld_funcs[] = {
   {"helloworld", (PyCFunction)helloworld,
      METH_NOARGS, helloworld_docs},
      {NULL}
};

static struct PyModuleDef hello =
{
    PyModuleDef_HEAD_INIT,
    "helloworld", /* name of module */
    "usage: Combinations.uniqueCombinations(lstSortableItems, comboSize)\n", /* module documentation, may be NULL */
    -1,   /* size of per-interpreter state of the module, or -1 if the module keeps state in global variables. */
    helloworld_funcs
};

PyMODINIT_FUNC PyInit_helloworld(void)
{
    return PyModule_Create(&hello);
}
