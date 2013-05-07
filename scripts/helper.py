from __future__ import print_function

def _output_status(failed, success):
  print("Ejecucion fallida en: ")
  for pc in failed:
    print(pc, end=" ")
  print("")
  print("Ejecucion exitosa en: ")
  for pc in success:
    print(pc, end=" ")