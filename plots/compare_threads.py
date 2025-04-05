#! /usr/bin/python3
import os
import subprocess
import matplotlib.pyplot as plt
import matplotlib

def run_model(threads):
  os.environ["OMP_NUM_THREADS"] = f"{threads}"
  run = subprocess.run(["time", "../bin/global-sums"], capture_output=True)
  elapsed = str(run.stderr).split("elapsed")[0][-5::]

  return elapsed

if __name__=="__main__":

  matplotlib.rc('font', family='serif') 

  plt.bar("1", float(run_model(1)), color="C0")
  plt.bar("2", float(run_model(2)), color="C0")
  plt.bar("4", float(run_model(4)), color="C0")
  plt.bar("8", float(run_model(8)), color="C0")
  plt.ylabel("Elapsed time [s]")
  plt.xlabel("No. of threads")
  plt.savefig("threads.png")
