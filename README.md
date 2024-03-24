# ELEC 5660 Project 2 Phase 1

Pre-built docker image contains all the dependencies and can be used as dev/deploy image, it is multi-arch and can run on both x86 and ARM devices.

## Dependencies

- Docker

## Usage

1. Build multi-arch docker image (Optional)

   1. Create a multi-arch builder instance and use, note that the `--platform` does not have space after the `,`:

      ```Shell
      docker buildx create \
      --name multi-platform \
      --use --platform \
      linux/amd64,linux/arm64 \
      --driver docker-container
      ```

   1. Build and push the image

      ```Shell
      docker buildx bake --push
      ```

1. Run in detach mode

   ```Shell
   docker-compose up -d
   ```

1. Attach

   ```Shell
   docker attach elec-5660-project-2-phase-1
   ```

1. Build and run

   ```Shell
   catkin build
   source devel/setup.zsh
   roscore &
   mon launch tag_detector bag_tab.launch
   ```
