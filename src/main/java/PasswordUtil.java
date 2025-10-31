import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public final class PasswordUtil {

    private static final String ALGORITHM = "PBKDF2WithHmacSHA256";
    private static final int SALT_BYTES = 16;
    private static final int HASH_BYTES = 32; // 256-bit
    private static final int ITERATIONS = 120000; // modern baseline

    private PasswordUtil() {}

    public static String hashPassword(char[] password) {
        byte[] salt = generateSalt();
        byte[] hash = pbkdf2(password, salt, ITERATIONS, HASH_BYTES);
        String saltB64 = Base64.getEncoder().encodeToString(salt);
        String hashB64 = Base64.getEncoder().encodeToString(hash);
        // format: algorithm:iterations:salt:hash
        return String.join(":", ALGORITHM, String.valueOf(ITERATIONS), saltB64, hashB64);
    }

    public static boolean verifyPassword(char[] password, String stored) {
        if (stored == null || stored.isEmpty()) return false;
        String[] parts = stored.split(":");
        if (parts.length != 4) return false;
        String algorithm = parts[0];
        int iterations = Integer.parseInt(parts[1]);
        byte[] salt = Base64.getDecoder().decode(parts[2]);
        byte[] expectedHash = Base64.getDecoder().decode(parts[3]);

        if (!ALGORITHM.equals(algorithm)) return false;

        byte[] computed = pbkdf2(password, salt, iterations, expectedHash.length);
        return slowEquals(expectedHash, computed);
    }

    private static byte[] pbkdf2(char[] password, byte[] salt, int iterations, int length) {
        try {
            PBEKeySpec spec = new PBEKeySpec(password, salt, iterations, length * 8);
            SecretKeyFactory skf = SecretKeyFactory.getInstance(ALGORITHM);
            return skf.generateSecret(spec).getEncoded();
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new IllegalStateException("PBKDF2 failure", e);
        }
    }

    private static byte[] generateSalt() {
        byte[] salt = new byte[SALT_BYTES];
        new SecureRandom().nextBytes(salt);
        return salt;
    }

    private static boolean slowEquals(byte[] a, byte[] b) {
        if (a == null || b == null || a.length != b.length) return false;
        int diff = 0;
        for (int i = 0; i < a.length; i++) {
            diff |= a[i] ^ b[i];
        }
        return diff == 0;
    }
}


