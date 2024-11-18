import 'package:appscrip/models/userModel.dart';
import 'package:appscrip/widgets/infocard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.user});
  final UserModel user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final latitude, longitude;

  @override
  void initState() {
    latitude = double.tryParse(widget.user.address?.geo?.lat ?? '0') ?? 0.0;
    longitude = double.tryParse(widget.user.address?.geo?.lng ?? '0') ?? 0.0;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              CircleAvatar(
                radius: 60,
                backgroundColor: const Color.fromARGB(0, 238, 238, 238),
                child: SvgPicture.asset(
                  'assets/icons/male.svg',
                  height: 120,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.user.name ?? 'No Name',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.user.email ?? 'No Email',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              const Divider(thickness: 1),
              buildInfoCard(
                icon: Icons.phone,
                title: 'Phone',
                content: widget.user.phone ?? 'No Phone Number',
              ),
              const SizedBox(height: 16),

              buildInfoCard(
                icon: Icons.location_on,
                title: 'Address',
                content:
                    "${widget.user.address?.street ?? 'No Street'}, ${widget.user.address?.city ?? 'No City'}",
              ),
              const SizedBox(height: 16),

              buildInfoCard(
                icon: Icons.business,
                title: 'Company',
                content: widget.user.company?.name ?? 'No Company',
              ),
              const SizedBox(height: 16),

              buildInfoCard(
                icon: Icons.web,
                title: 'Website',
                content: widget.user.website ?? 'No Website',
                isLink: true,
              ),
                            const SizedBox(height: 16),
                            
              SizedBox(
                height: 300,
                child: FlutterMap(
                  
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
                    initialZoom: 5,
                    
                  ),
                  children: [
                  
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.appscrip',
                    ),
                      MarkerLayer(markers: [ Marker(
                    width: 80.0,
                    height: 80.0,
                    point: LatLng(latitude, longitude),
                    child: 
                        Icon(Icons.pin_drop, color: Colors.red),
                ),],),
                    
                  ],
                  
                  
                ),
              ),
                            const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
