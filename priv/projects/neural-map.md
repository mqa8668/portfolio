%{
  title: "Neural Map: Flutter Brain Visualization App",
  description: "Mobile app with an interactive brain visualization, animated neural networks and wellness tools.",
  tags: ["flutter", "mobile", "wellness"],
  tech: ["Flutter", "Dart", "Custom Paint", "Animation"],
  date: ~D[2024-06-01],
  featured: false,
  status: "development",
  metrics: [
    %{label: "Animation", value: "60fps"},
    %{label: "Node Range", value: "35-250+"},
    %{label: "Interactions", value: "Touch-based"}
  ],
  hero_image: nil
}
---

I designed Neural Map as a mobile app that visualizes cognitive and emotional states as an interactive neural network in a cosmic style. It turns abstract wellness concepts into something users can see and interact with.

The technical challenge was rendering a dynamic neural network with 35 to 250+ animated nodes at a consistent 60fps on mobile hardware. Each node pulses, connects to its neighbors through curved Bezier paths and responds to user input, so it needed careful optimization to avoid frame drops on mid-range devices.

I built the visualization engine entirely on Flutter's Custom Paint API, bypassing standard widgets for direct canvas control. The rendering pipeline uses spatial partitioning to cull off-screen nodes, batches draw calls to minimize GPU state changes and uses object pooling to avoid garbage collection pauses during animations. Connections between nodes are quadratic Bezier curves calculated on each frame, with opacity and color interpolated from connection strength.

Tapping a node highlights its connections and shows associated data, panning moves around the network, and pinch-zoom goes from a high-level overview down to individual node clusters. The gesture system handles simultaneous inputs without conflicting with the animation loop.

Besides the visualization, the app has a Mind Garden for tracking mental wellness over time, a Test Scoring module for standardized assessments and a Mini Diary for journaling. Each feature feeds data back into the visualization.
