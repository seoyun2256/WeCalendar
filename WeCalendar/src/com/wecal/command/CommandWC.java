package com.wecal.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface CommandWC {
    public void execute(HttpServletRequest request, HttpServletResponse response);
}
