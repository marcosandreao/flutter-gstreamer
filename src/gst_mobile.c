#include "gst_mobile.h"

#include <gst/gst.h>


FFI_PLUGIN_EXPORT char* maao_gst_version() {
    return gst_version_string();
}