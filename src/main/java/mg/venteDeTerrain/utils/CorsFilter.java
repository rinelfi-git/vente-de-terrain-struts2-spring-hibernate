package mg.venteDeTerrain.utils;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CorsFilter implements Filter {
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {}
	
	@Override
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		// Authorize (allow) all domains to consume the content
		((HttpServletResponse) servletResponse).addHeader("Access-Control-Allow-Origin", "*");
		((HttpServletResponse) servletResponse).addHeader("Access-Control-Allow-Methods","GET, OPTIONS, HEAD, PUT, POST");
		((HttpServletResponse) servletResponse).addHeader("Access-Control-Allow-Headers","X-Requested-With,Cache-Control,content-type,Accept,DNT,X-CustomHeader,Keep-Alive,Utilisateur-Agent");
		((HttpServletResponse) servletResponse).addHeader("Access-Control-Allow-Credentials","true");
		
		HttpServletResponse resp = (HttpServletResponse) servletResponse;
		
		// For HTTP OPTIONS verb/method reply with ACCEPTED status code -- per CORS handshake
		if (request.getMethod().equals("OPTIONS")) {
			resp.setStatus(HttpServletResponse.SC_ACCEPTED);
			return;
		}
		// pass the servletRequest along the filter filterChain
		filterChain.doFilter(request, servletResponse);
	}
	
	@Override
	public void destroy() {
	
	}
}
