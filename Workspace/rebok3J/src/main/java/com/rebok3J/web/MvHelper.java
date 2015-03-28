package com.rebok3J.web;

import org.springframework.web.servlet.ModelAndView;

/**
 * @author OrestO
 * @since 3/28/2015
 */
public class MvHelper {
  public static ModelAndView get(String content)
  {
    ModelAndView modelAndView = new ModelAndView("layout/layout");
    modelAndView.addObject("content", content);
    return modelAndView;
  }
}
