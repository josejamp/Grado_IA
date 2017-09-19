package utils;

import java.util.Scanner;
import java.util.regex.Pattern;

public class CompruebaDatos {

	
	public static boolean isInteger(String s) {
		boolean ok = true;
	    if(!s.isEmpty()){
	    	int i = 0;
	    	if(i == 0 && s.charAt(i) == '-') {
	            if(s.length() == 1) ok = false;
	            else i++;
	        }
		    while((i < s.length()) && ok) {
		    	if(i == 0 && s.charAt(i) == '-') {
		            if(s.length() == 1) ok = false;
		        }
		        if(Character.digit(s.charAt(i),10) < 0) ok = false;
		        else i++;
		    }
	    }
	    else ok = false;
	    return ok;
	}
	
	public static boolean isFloat(String myString){
  	  final String Digits     = "(\\p{Digit}+)";
  	  final String HexDigits  = "(\\p{XDigit}+)";
  	  // an exponent is 'e' or 'E' followed by an optionally
  	  // signed decimal integer.
  	  final String Exp        = "[eE][+-]?"+Digits;
  	  final String fpRegex    =
  	      ("[\\x00-\\x20]*"+  // Optional leading "whitespace"
  	       "[+-]?(" + // Optional sign character
  	       "NaN|" +           // "NaN" string
  	       "Infinity|" +      // "Infinity" string

  	       // A decimal floating-point string representing a finite positive
  	       // number without a leading sign has at most five basic pieces:
  	       // Digits . Digits ExponentPart FloatTypeSuffix
  	       //
  	       // Since this method allows integer-only strings as input
  	       // in addition to strings of floating-point literals, the
  	       // two sub-patterns below are simplifications of the grammar
  	       // productions from section 3.10.2 of
  	       // The Java™ Language Specification.

  	       // Digits ._opt Digits_opt ExponentPart_opt FloatTypeSuffix_opt
  	       "((("+Digits+"(\\.)?("+Digits+"?)("+Exp+")?)|"+

  	       // . Digits ExponentPart_opt FloatTypeSuffix_opt
  	       "(\\.("+Digits+")("+Exp+")?)|"+

  	       // Hexadecimal strings
  	       "((" +
  	        // 0[xX] HexDigits ._opt BinaryExponent FloatTypeSuffix_opt
  	        "(0[xX]" + HexDigits + "(\\.)?)|" +

  	        // 0[xX] HexDigits_opt . HexDigits BinaryExponent FloatTypeSuffix_opt
  	        "(0[xX]" + HexDigits + "?(\\.)" + HexDigits + ")" +

  	        ")[pP][+-]?" + Digits + "))" +
  	       "[fFdD]?))" +
  	       "[\\x00-\\x20]*");// Optional trailing "whitespace"

  	   return (Pattern.matches(fpRegex, myString));
	}
}
