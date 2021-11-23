package mg.ventedeterrain.utils.token;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.io.Serializable;
import java.lang.reflect.Type;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

public class Token implements Serializable {
	private TokenHeader header;
	private TokenPayload payload;
	
	public Token() {super();}
	
	public Token(String token) {
		String decodedToken = new String(Base64.getDecoder().decode(token));
		Gson jsonEndec = new Gson();
		Token json = jsonEndec.fromJson(decodedToken, Token.class);
		this.payload = json.payload;
		this.header = json.header;
	}
	
	public TokenHeader getHeader() {
		return header;
	}
	
	public void setHeader(TokenHeader header) {
		this.header = header;
	}
	
	public TokenPayload getPayload() {
		return payload;
	}
	
	public void setPayload(TokenPayload payload) {
		this.payload = payload;
	}
	
	public String generate() {
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("header", this.header);
		dataMap.put("payload", this.payload);
		Gson gson = new Gson();
		return Base64.getEncoder().encodeToString(gson.toJson(dataMap).getBytes(StandardCharsets.UTF_8));
	}
	
	public static boolean verifier(String token) {
		String decodedToken = new String(Base64.getDecoder().decode(token));
		Gson jsonEndec = new Gson();
		boolean valide = true;
		Type mapType = new TypeToken<HashMap<String, Object>>() {}.getType();
		HashMap<String, Object> json = jsonEndec.fromJson(decodedToken, mapType);
		
		TokenHeader staticHeader = jsonEndec.fromJson(json.get("header").toString(), TokenHeader.class);
		if (staticHeader.getDateExpiration() < System.currentTimeMillis()) {
			valide = false;
		}
		return valide;
	}
}
