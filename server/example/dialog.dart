import 'dart:io';

import 'package:setonix_server/setonix_server.dart';

Future<void> main(List<String> arguments) {
  return runServer(arguments, onLoad);
}

// AI generated test text
const testContent = """
## The Importance of Programming in Today's World

Programming, once a niche skill, has become an essential tool in almost every industry. From healthcare to finance, from education to entertainment, programming underpins the technologies that drive our modern world. This article will explore the significance of programming in today's society.

### 1. Technological Innovation
* **Driving Progress:** Programming is the catalyst for technological advancements. It's the language used to create new software, apps, and systems that improve our lives. 
* **Automation and Efficiency:** Programming enables automation, streamlining tasks and increasing efficiency across various sectors.
* **Problem Solving:** Programmers are skilled problem solvers, developing innovative solutions to complex challenges.

### 2. Economic Growth
* **Job Creation:** The programming industry has created numerous high-paying jobs, contributing significantly to economic growth.
* **Competitive Advantage:** Businesses that embrace programming and technology often have a competitive edge in the marketplace.
* **Digital Transformation:** Programming is essential for digital transformation, helping companies adapt to the changing technological landscape.

### 3. Education and Research
* **Learning Tools:** Programming is used to create educational software, games, and simulations, making learning more engaging and effective.
* **Research Tools:** Researchers rely on programming to analyze data, develop models, and conduct experiments.
* **Accessibility:** Programming can be used to create assistive technologies for people with disabilities, promoting inclusivity.

### 4. Global Connectivity
* **Communication and Collaboration:** Programming powers the internet and social media platforms, facilitating global communication and collaboration.
* **E-commerce:** Programming is essential for online shopping and e-commerce platforms, driving economic activity worldwide.
* **Remote Work:** Programming enables remote work, fostering a more flexible and global workforce.

### 5. Creativity and Innovation
* **Digital Art and Design:** Programming is used to create digital art, animations, and interactive experiences.
* **Game Development:** Programmers play a crucial role in developing video games, a popular form of entertainment.
* **New Possibilities:** Programming allows for the creation of entirely new products, services, and industries.

In conclusion, programming has become an indispensable skill in the modern world. It drives technological innovation, fuels economic growth, supports education and research, enables global connectivity, and fosters creativity. As technology continues to evolve, the importance of programming will only increase.
""";

Future<void> onLoad(SetonixServer server) async {
  print("on load was called");
  final image = await File("../app/images/logo.png").readAsBytes();
  server.process(ImagesUpdated.single('logo', image));
  server.eventSystem
    ..on<ObjectsMoved>((e) {
      print("Listener was called, opening dialog");
      server.sendEvent(DialogOpened(
        GameDialog(id: "testDialog", title: "TestDialog", image: "logo")
            .markdown(testContent)
            .textField(
              "TestTextField",
              id: "testTextField",
              placeholder: "TestPlaceholder",
              multiline: true,
              password: true,
            )
            .action(GameDialogButton("TestButton")),
      ));
    })
    ..on<UserJoined>((e) {
      print("play joined");
    })
    ..on<DialogCloseRequest>((e) {
      final value = e.clientEvent.value;
      print("Dialog ${e.clientEvent.id} closed, got ${e.clientEvent.value}");
      if (value != null) {
        e.cancel();
      }
    });
}
