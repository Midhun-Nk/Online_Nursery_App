
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:online_nursery_plant_shop/features/personalization/controllers/user_controller.dart';
import 'package:online_nursery_plant_shop/utils/constants/colors.dart';
import 'package:online_nursery_plant_shop/utils/constants/image_strings.dart';

import '../../shop/widget/brandshowcase.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required this.onPressed,
  });

final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
 leading: const TCircularImage(
       width: 50,
       height: 50,
       padding: 0,
       image: TImages.user,
       ),
       title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
     subtitle: Text(controller.user.value.email, 
     maxLines: 1,
      overflow: TextOverflow.ellipsis,
     style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),),
     trailing:  IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit,color: TColors.white,)),
                  );
                  
  }
}
