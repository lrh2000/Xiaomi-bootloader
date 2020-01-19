import sys
import io
from adb.fastboot import FastbootCommands
from adb.fastboot import FastbootRemoteFailure

if len(sys.argv) != 2:
    print(f"Usage: {sys.argv[0]} [signature file]")
    sys.exit(1)

fdev = FastbootCommands()
fdev.ConnectDevice()

sig = open(sys.argv[1], 'rb')
sig_data = sig.read()
sig.close()

print("Ready to unlock your phone.")
print("If it succeeds, it will ERASE ALL YOUR DATA. Take your own risk.")
input("Press <ENTER> to continue and <CTRL+C> to exit...")
print("")

fdev.Download(io.BytesIO(sig_data), len(sig_data))
try:
    res = fdev.Oem("unlock")
    print("Successful!")
    print(f"Remote response: {res}")
except FastbootRemoteFailure as e:
    print("Failed.")
    print(f"Remote response: {e.args[0][6:]}")
