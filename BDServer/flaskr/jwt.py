import json
from base64 import urlsafe_b64decode, urlsafe_b64encode
import hmac
import time

def b64encode(s: bytes) -> str: # Base64 encoding
    s_bin = urlsafe_b64encode(s)
    s_bin = s_bin.replace(b'=', b'')
    return s_bin.decode('ascii')

def b64decode(s: str) -> bytes: # Base64 decoding
    s_bin = s.encode('ascii')
    s_bin += b'=' * (4 - len(s_bin) % 4)
    return urlsafe_b64decode(s_bin)

_secret = b"el-psy-kongroo"

default_header = {"typ":"JWT","alg":"HS256"} # default header

def JWTgenerator(payload, header=default_header):
    global _secret
    header_b64 = b64encode(json.dumps(header, separators=(',',":")).encode('ascii'))
    payload_b64 = b64encode(json.dumps(payload, separators=(",",":")).encode('utf-8'))
    message = header_b64 + "." + payload_b64
    signature = hmac.new(_secret, message.encode('ascii'), digestmod='sha256').digest()
    signature_b64 = b64encode(signature)
    jwt = message + "." + signature_b64
    return jwt

def get_userJWT(userID):
    payload = {"userID":str(userID),"iat":str(time.time())}
    userJWT = JWTgenerator(payload)
    return userJWT