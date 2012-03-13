package net.socialgamer.cah;

import java.io.IOException;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletResponse;


public class CacheControlFilter implements Filter {

  @Override
  public void doFilter(final ServletRequest request, final ServletResponse response,
      final FilterChain chain) throws IOException, ServletException {

    final HttpServletResponse resp = (HttpServletResponse) response;

    // 1 hour
    resp.setHeader("Expires",
        new Date(System.currentTimeMillis() + (60L * 60L * 1000L)).toString());
    resp.setHeader("Last-Modified", new Date().toString());
    resp.setHeader("Cache-Control", "must-revalidate, max-age=3600");

    chain.doFilter(request, response);
  }

  @Override
  public void init(final FilterConfig filterConfig) throws ServletException {
    // pass
  }

  @Override
  public void destroy() {
    // TODO pass
  }

}
