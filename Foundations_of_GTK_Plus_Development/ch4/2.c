#include <gtk/gtk.h>

typedef struct {
  GtkWidget *spin, *scale, *check;
} Widgets;

static void range_change(GtkWidget *widget, Widgets *w) {
  if (gtk_toggle_button_get_active(GTK_TOGGLE_BUTTON(w->check))) {
    gdouble spin_value = gtk_spin_button_get_value(GTK_SPIN_BUTTON(w->spin));
    gdouble scale_value = gtk_range_get_value(GTK_RANGE(w->scale));

    if (spin_value != scale_value) {
      if (GTK_IS_SPIN_BUTTON(widget)) {
        gtk_range_set_value(GTK_RANGE(w->scale), spin_value);
      } else {
        gtk_spin_button_set_value(GTK_SPIN_BUTTON(w->spin), scale_value);
      }
    }
  }
}

int main(int argc, char *argv[]) {
  gtk_init(&argc, &argv);

  GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title(GTK_WINDOW(window), "4.2");
  gtk_container_set_border_width(GTK_CONTAINER(window), 5);
  gtk_widget_set_size_request(window, 250, 150);

  Widgets *w = (Widgets *)g_malloc(sizeof(Widgets));

  w->spin = gtk_spin_button_new_with_range(0, 10, 1);
  w->scale = gtk_scale_new_with_range(GTK_ORIENTATION_HORIZONTAL, 0, 10, 1);
  w->check = gtk_check_button_new_with_label("Sync");

  GtkWidget *box = gtk_box_new(GTK_ORIENTATION_VERTICAL, 10);
  gtk_box_pack_start(GTK_BOX(box), w->spin, FALSE, TRUE, 5);
  gtk_box_pack_start(GTK_BOX(box), w->scale, FALSE, TRUE, 5);
  gtk_box_pack_start(GTK_BOX(box), w->check, FALSE, TRUE, 5);

  g_signal_connect(G_OBJECT(w->spin), "value-changed", G_CALLBACK(range_change),
                   (gpointer)w);
  g_signal_connect(G_OBJECT(w->scale), "value-changed",
                   G_CALLBACK(range_change), (gpointer)w);

  gtk_container_add(GTK_CONTAINER(window), box);
  gtk_widget_show_all(window);

  gtk_main();

  return 0;
}
