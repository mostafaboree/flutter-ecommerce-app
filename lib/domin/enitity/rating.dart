

import 'package:equatable/equatable.dart';
 
class Rating extends Equatable{

  final double rate;
  final int count;

  Rating({
    required this.rate,
    required this.count,
  });
  
  @override
  List<Object?> get props => [rate,count] ;
}