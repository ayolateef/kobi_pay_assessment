import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kobi_pay_assessment/constants/app_colors.dart';

class AppTextStyles {
  static final TextStyle appBarTitle = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  static final TextStyle netflixTitle = GoogleFonts.roboto(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static final TextStyle productionCompany = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final TextStyle totalPayment = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  static final TextStyle totalAmount = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final TextStyle pieChartAmount = GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.amount,
  );
  static final TextStyle month = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  static final TextStyle transactionsHeader = GoogleFonts.roboto(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static final TextStyle transactionTitle = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  static final TextStyle transactionDate = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
  static final TextStyle transactionAmount = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.amount,
  );
}