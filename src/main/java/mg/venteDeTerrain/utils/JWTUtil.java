package mg.venteDeTerrain.utils;

import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;

import java.security.KeyPair;
import java.security.PrivateKey;
import java.security.PublicKey;

public class JWTUtil {
    private static KeyPair keyPair;
    
    public static void getInstance() {
        if (JWTUtil.keyPair == null) JWTUtil.keyPair = Keys.keyPairFor(SignatureAlgorithm.RS256);
    }
    
    public static PublicKey getPublicKey() {
        return JWTUtil.keyPair.getPublic();
    }
    
    public static PrivateKey getPrivateKey() {
        return JWTUtil.keyPair.getPrivate();
    }
}
