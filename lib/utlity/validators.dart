class Validators {


  static Function passValidator = (value) {
    if (value.isEmpty) {
      return 'هذا الحقل لا يمكن تركه فارغاً';
    } else if (value.length < 8) {
      return 'كلمة المرور يجب ان تكون 8 حروف او اكثر';
    }
    return null;
  };
  static  Function idValidator = (value) {
    bool idValid = true;
    if (value.isEmpty) {
      return 'هذا الحقل لا يمكن تركه فارغاً';
    } else if (value.length != 13) {
      return 'يجب ان يتكون الرقم من 13 ارقام';
    } else if (double.tryParse(value) == null) {
      return 'يجب ان يحتوي على ارقام فقط';
    } else if (!idValid) {
      return 'يرجى التحقق من كتابة الرقم بشكل صحيح';
    }
    return null;
  };
static  Function phoneNumberValidator = (value) {
    bool idValid = true;
    if (value.isEmpty) {
      return 'هذا الحقل لا يمكن تركه فارغاً';
    } else if (value.length != 10) {
      return 'يجب ان يتكون الرقم من 10 ارقام';
    } else if (double.tryParse(value) == null) {
      return 'يجب ان يحتوي على ارقام فقط';
    } else if (!idValid) {
      return 'يرجى التحقق من كتابة الرقم بشكل صحيح';
    }
    return null;
  };
    static Function nameValidator = (value) {
    if (value.isEmpty) {
      return 'هذا الحقل لا يمكن تركه فارغاً';
    } 
    return null;
  };
      static Function dateValidator = (value) {
    if (value == null ||value.isEmpty) {
      return 'هذا الحقل لا يمكن تركه فارغاً';
    } 
    return null;
  };
static  Function phoneCheckValidator = (value) {
    bool idValid = true;
    if (value.isEmpty) {
      return 'هذا الحقل لا يمكن تركه فارغاً';
    } else if (value.length != 4) {
      return 'يجب ان يتكون الرمز من 4 ارقام';
    } else if (double.tryParse(value) == null) {
      return 'يجب ان يحتوي الرمز على ارقام فقط';
    } else if (! idValid) {
      return 'يرجى التحقق من كتابة الرمز بشكل صحيح' ;
    }
    return null;
   
  };

}