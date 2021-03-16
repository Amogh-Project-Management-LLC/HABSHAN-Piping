window.onload = drawModel;

function getParameterByName(name) {
  url = window.location.href;
  name = name.replace(/[\[\]]/g, "\\$&");
  var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
    results = regex.exec(url);
  if (!results) return null;
  if (!results[2]) return '';
  return decodeURIComponent(results[2].replace(/\+/g, " "));
}


// main function
function drawModel() {
  var pcf = getParameterByName('pcf');
  var proj_id = getParameterByName('proj_id');
  console.log(pcf);
  console.log(proj_id);

  var serivceUrl = "https://amoghapps.com/Amogh3DService/";
  var scene = new THREE.Scene();
  scene.background = new THREE.Color(0xcccccc);
  var canvas_height = getCanvasHeight();
  var camera = new THREE.PerspectiveCamera(60, window.innerWidth / canvas_height, 0.01, 1000);
  var renderer = new THREE.WebGLRenderer({
    antialias: true
  });
  renderer.setSize(window.innerWidth, canvas_height);
  var objTo = document.getElementById('canvasDiv');
  objTo.innerHTML = '';
  // document.body.appendChild(renderer.domElement);
  objTo.appendChild(renderer.domElement);


  window.addEventListener('resize', function() {
    var width = window.innerWidth;
    canvas_height = getCanvasHeight();
    renderer.setSize(width, canvas_height);
    camera.aspect = width / canvas_height;
    camera.updateProjectionMatrix();
  });

  camera.position.set(0, 5, 5);
  camera.up.set(0, 0, 1);

  controls = new THREE.OrbitControls(camera, renderer.domElement);
  controls.enableDamping = true; // an animation loop is required when either damping or auto-rotation are enabled
  controls.dampingFactor = 0.07; // friction
  controls.rotateSpeed = 0.04; // mouse sensitivity
  controls.panSpeed = 0.1; // pan speed
  controls.zoomSpeed = 0.5;
  controls.screenSpacePanning = false;

  controls.minDistance = 0;
  controls.maxDistance = 500
  controls.maxPolarAngle = Math.PI / 2.1;

  controls.update();

  var ambientLight = new THREE.AmbientLight(0xFFFFFF, 0.2);
  scene.add(ambientLight);

  var directionalLight = new THREE.DirectionalLight(0xffffff, 0.5);
  directionalLight.position.z = 10
  scene.add(directionalLight);

  var grid = new THREE.GridHelper(500, 200);
  grid.geometry.rotateX(Math.PI / 2);
  scene.add(grid);

  var e = document.getElementById("ddlStatus");
  var strStatus = e.options[e.selectedIndex].value;
  // console.log(strStatus);

  fetch(serivceUrl + 'WebService1.asmx/GetPCFThree?proj_id=' + proj_id + '&pcf=' + pcf)
    .then(function(response) {
      console.log(response);
      return response.json();
    })
    .then(function(myJson) {
      console.log(myJson);
      myJson.forEach(function(comp3D) {
        // console.log("Test");
        console.log(comp3D);
        var color1 = "0x4f87ef";

        if ((strStatus == 'mat_avl' && comp3D.mat_avl == true) ||
          (strStatus == 'welded' && comp3D.welded == true) ||
          (strStatus == 'insatalled' && comp3D.insatalled == true)) {
            color1 = '0x31CA27';
        }

        comp3D.Cylinders.forEach(function(cylinder) {
          // console.log(cylinder);
          var geom = new THREE.CylinderGeometry(cylinder.radiusTop, cylinder.radiusBottom, cylinder.height, 32);
          geom.openEnded = false;
          // var color1 = '0x' + getRandomColor();
          var mat = new THREE.MeshPhongMaterial({
            color: parseInt(color1)
          });
          var mesh1 = new THREE.Mesh(geom, mat);
          mesh1.position.set(cylinder.posX, cylinder.posY, cylinder.posZ);
          var vector = new THREE.Vector3(cylinder.axisX, cylinder.axisY, cylinder.axisZ);
          var axis = new THREE.Vector3(0, 1, 0);
          mesh1.quaternion.setFromUnitVectors(axis, vector.clone().normalize());
          scene.add(mesh1);
        });

        comp3D.Elbows.forEach(function(elbow) {
          // console.log(elbow);
          var mat = new THREE.MeshPhongMaterial({
            color: parseInt(color1),
            side: THREE.DoubleSide
          });
          var pipeSpline = new THREE.CatmullRomCurve3();
          var points = elbow.points;
          points.forEach(function(pt) {
            pipeSpline.points.push(new THREE.Vector3(pt.X, pt.Y, pt.Z));
          });

          // console.log(pipeSpline);
          var segments = 20;
          var radiusSegments = 20;
          var closed = false;
          var tubeGeometry = new THREE.TubeBufferGeometry(pipeSpline, segments, elbow.radius, radiusSegments, closed);
          var mesh3 = new THREE.Mesh(tubeGeometry, mat);
          scene.add(mesh3);
        });
      });
    });

  // game logic
  var update = function() {
    // cube.rotation.x += 0.01;
    // cube.rotation.y += 0.005
  };

  // draw scence
  var render = function() {
    renderer.render(scene, camera);
  };

  var GameLoop = function() {
    requestAnimationFrame(GameLoop);

    update();
    render();
  };

  GameLoop();
}

function getCanvasHeight() {
  return window.innerHeight - 70;
}


function getRandomColor() {
  var letters = '0123456789ABCDEF';
  var color = "";
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

// function animate() {
//
//   requestAnimationFrame(animate);
//   // required if controls.enableDamping or controls.autoRotate are set to true
//   controls.update();
//   renderer.render(scene, camera);
// }


function updateClick() {
  drawModel();
}
