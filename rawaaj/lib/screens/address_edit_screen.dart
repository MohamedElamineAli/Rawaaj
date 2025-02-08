import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/text_field_widget.dart';
import '../cubit/location_cubit.dart';
import '../widgets/dropdown_widget.dart';
import '../widgets/save_button.dart';
import '../widgets/sub_screen_app_bar.dart';

class LocationEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const SubScreenAppBar(name: "Location Address"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<LocationCubit, LocationState>(
              builder: (context, state) {
                if (state is LocationLoaded) {
                  final cubit = context.read<LocationCubit>();
                  print("w: ${state.wilaya}, d: ${state.daira}, c: ${state.commune}");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      DropdownWidget(
                        label: 'Wilaya',
                        hint: state.wilaya,
                        items: [],
                        onChanged: (value) {
                          if (value != null) cubit.updateWilaya(value);
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownWidget(
                        label: 'Daira',
                        disabledHint: state.daira,
                        items: [],
                      ),
                      const SizedBox(height: 16),
                      DropdownWidget(
                        label: 'Commune',
                        disabledHint: state.commune,
                        items: [],
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Address',
                        hint: state.address ?? '',
                      ),
                      const SizedBox(height: 32),
                      SaveButton(
                        onPressed: () {
                          cubit.saveLocation();
                        },
                      ),
                    ],
                  );
                } else if (state is LocationLoading || state is LocationUpdated) {
                  print("statingus");
                  final cubit = context.read<LocationCubit>();
                  final wilaya = (state is LocationLoading) ? state.wilaya : (state as LocationUpdated).wilaya;
                  final daira = (state is LocationLoading) ? state.daira : (state as LocationUpdated).daira;
                  final commune = (state is LocationLoading) ? null : (state as LocationUpdated).commune;
                  final address = (state is LocationLoading) ? null : (state as LocationUpdated).address;
                  final wilayasList = (state is LocationLoading) ? state.wilayasList : null;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      DropdownWidget(
                        label: 'Wilaya',
                        hint: wilaya ?? 'Select Wilaya',
                        items: wilayasList ?? [],
                        onChanged: (value) {
                          if (value != null) cubit.updateWilaya(value);
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownWidget(
                        label: 'Daira',
                        hint: daira ?? 'Select Daira',
                        items: LocationCubit().getDairas(wilaya),
                        onChanged: (value) {
                          if (value != null) cubit.updateDaira(value);
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownWidget(
                        label: 'Commune',
                        hint: commune ?? 'Select Commune',
                        items: LocationCubit().getCommunes(daira),
                        onChanged: (value) {
                          if (value != null) cubit.updateCommune(value);
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Address',
                        hint: address ?? '',
                        onChanged: (value) {
                          if (value.isNotEmpty) cubit.updateAddress(value);
                        },
                      ),
                      const SizedBox(height: 32),
                      SaveButton(
                        onPressed: () {
                          cubit.saveLocation();
                        },
                      ),
                    ],
                  );
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}