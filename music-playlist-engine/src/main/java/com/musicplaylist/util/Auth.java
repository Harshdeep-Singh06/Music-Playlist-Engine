package com.musicplaylist.util;
import jakarta.servlet.http.*;
public class Auth { public static Integer userId(HttpServletRequest r){HttpSession s=r.getSession(false);return s==null?null:(Integer)s.getAttribute("userId");} }